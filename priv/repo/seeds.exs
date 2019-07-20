# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EventPromoCode.Repo.insert!(%EventPromoCode.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias EventPromoCode.Repo
alias EventPromoCode.Event
alias EventPromoCode.PromoCode

Repo.delete_all(PromoCode)
Repo.delete_all(Event)

event_data = [
  %{
    title: "Shanghai Masters",
    description: "The Shanghai Masters is a professional men's tennis tournament played on outdoor hard courts, and held annually in early October at the Qizhong Forest Sports City Arena in the Minhang District of Shanghai",
    latitude: 31.039904,
    longitude: 121.359025,
    start_at: DateTime.from_naive!(~N[2019-10-02 00:00:00], "Etc/UTC"),
    end_at: DateTime.from_naive!(~N[2019-10-08 20:00:00], "Etc/UTC")
  },
  %{
    title: "Wu-Tang Clan",
    description: "Riverside Theatre, Milwaukee, WI, US",
    latitude: 43.0389645,
    longitude: -87.9108857,
    start_at: DateTime.from_naive!(~N[2019-11-15 20:00:00], "Etc/UTC"),
    end_at: DateTime.from_naive!(~N[2019-11-15 23:00:00], "Etc/UTC")
  },
  %{
    title: "Ruby Conf TH",
    description: "First Ruby Conference in Bangkok",
    latitude: 13.75893,
    longitude: 100.5352399,
    start_at: DateTime.from_naive!(~N[2019-12-11 10:00:00], "Etc/UTC"),
    end_at: DateTime.from_naive!(~N[2019-12-13 17:00:00], "Etc/UTC")
  }
]

Enum.each(event_data, fn(data) ->
  Repo.insert! %Event{
    title: data.title,
    description: data.description,
    latitude: data.latitude,
    longitude: data.longitude,
    start_at: data.start_at,
    end_at: data.end_at
  }
end)

promo_code_data = [
  %{
    event: Repo.get_by(Event, title: "Shanghai Masters"),
    code: "3gs9",
    amount: 10.00,
    expires_at: DateTime.from_naive!(~N[2017-12-12 00:00:00], "Etc/UTC"),
    is_active: true,
    radius: 10.00
  },
  %{
    event: Repo.get_by(Event, title: "Shanghai Masters"),
    code: "21nd",
    amount: 30.00,
    expires_at: DateTime.from_naive!(~N[2019-12-30 00:00:00], "Etc/UTC"),
    is_active: false,
    radius: 200.00
  },
  %{
    event: Repo.get_by(Event, title: "Shanghai Masters"),
    code: "c1xa",
    amount: 100.00,
    expires_at: DateTime.from_naive!(~N[2020-10-21 00:00:00], "Etc/UTC"),
    is_active: true,
    radius: 500.00
  }
]

Enum.each(promo_code_data, fn(data) ->
  Repo.insert! %PromoCode{
    event_id: data.event.id,
    code: data.code,
    amount: data.amount,
    expires_at: data.expires_at,
    is_active: data.is_active,
    radius: data.radius
  }
end)
