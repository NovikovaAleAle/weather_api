class HealthController < ApplicationController
    def status
        render plain: 'OK', status: :ok
    end
end
