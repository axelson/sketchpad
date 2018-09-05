defmodule SketchpadWeb.PadChannel do
  use SketchpadWeb, :channel

  def topic(pad_id), do: "pad:#{pad_id}"

  def broadcast_stroke_from(from, pad_id, user_id, stroke) do
    payload = %{
      user_id: user_id,
      stroke: stroke
    }
    SketchpadWeb.Endpoint.broadcast_from!(from, topic(pad_id), "stroke", payload)
  end

  def join("pad:" <> pad_id, _params, socket) do
    socket =
      socket
      |> assign(:pad_id, pad_id)

    {:ok, socket}
  end

  def handle_in("stroke", data, socket) do
    %{user_id: user_id, pad_id: pad_id} = socket.assigns
    broadcast_stroke_from(self(), pad_id, user_id, data)

    {:reply, :ok, socket}
  end
end
