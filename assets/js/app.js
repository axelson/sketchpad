import css from "../css/app.css"
import "phoenix_html"
import {Socket, Presence} from "phoenix"
import {Sketchpad, sanitize} from "./sketchpad"

let socket = new Socket("/socket", {
  params: {token: window.userToken},
  logger: function(kind, msg, data) {
    console.log(`${kind}: ${msg}`, data)
  }
})

let App = {
  init() {
    socket.connect()

    this.padChannel = socket.channel("pad:lobby")
    this.el = document.getElementById("sketchpad")
    this.pad = new Sketchpad(this.el, window.userame)

    this.bind()

    this.padChannel.join()
      .receive("ok", resp => console.log("joined!", resp))
      .receive("error", resp => console.log("failed to join", resp))
  },

  bind() {
    this.pad.on("stroke", data => this.padChannel.push("stroke", data))

    this.padChannel.on("stroke", ({user_id, stroke}) => {
      this.pad.putStroke(user_id, stroke, {color: "#000"})
    })
  },
}

if (window.userToken !== "") App.init()
