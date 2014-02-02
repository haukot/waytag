class Web::Admin::DashboardController < Web::Admin::ApplicationController

  def show
    colors = %w(C75646 8EB33B D0B03C 72B3CC C8A0D1 218693 B0B0B0)

    kinds = Report.source_kind.values
    gon.reports = kinds.map.with_index do |k, i|
      {
        label: t(k),
        value: Report.where(source_kind: k).count,
        color: colors[i]
      }
    end

    users = {
      api: ApiUser.api.count,
      ios: ApiUser.ios.count,
      android: ApiUser.android.count,
      web: WebUser.count,
      twitter: TwitterUser.count
    }

    gon.users = users.map.with_index do |k, i|
      {
        label: t(k.first),
        value: k.last,
        color: colors[i]
      }
    end

    @reports = gon.reports
    @users = gon.users
  end

end
