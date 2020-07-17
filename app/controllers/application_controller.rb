class ApplicationController < ActionController::Base
  layout :set_layout

  rescue_from StandardError, with: :rescue500
  rescue_from Forbidden, with: :rescue403
  rescue_from IpAddressRejected, with: :rescue403

  private def set_layout
    if params[:controller].match(%r{\A(admin)/})
      Regexp.last_match[1]
    else
      "application"
    end
  end

  private def rescue500(e)
    render "errors/internal_server_error", status: 500
  end
end

