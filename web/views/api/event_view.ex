defmodule EventPromoCode.Api.EventView do
  use EventPromoCode.Web, :view

  def render("event.json", %{event: event}) do
    %{id: event.id,
      title: event.title,
      description: event.description,
      start_at: event.start_at,
      end_at: event.end_at}
  end
end
