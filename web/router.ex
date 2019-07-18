defmodule EventPromoCode.Router do
  use EventPromoCode.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventPromoCode do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/events", EventController
    resources "/promo_codes", PromoCodeController
  end

  # Other scopes may use custom stacks.
  # scope "/api", EventPromoCode do
  #   pipe_through :api
  # end
end
