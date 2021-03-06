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

  scope "/api", EventPromoCode.Api, as: :api do
    pipe_through :api

    scope "/v1" do
      resources "/promo_codes", PromoCodeController, only: [:show, :index, :create, :update]
      resources "/promo_codes_validation", PromoCodeValidationController, only: [:create]
    end
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
