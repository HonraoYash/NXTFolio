# frozen_string_literal: true

module RollbackLogger
  extend ActiveSupport::Concern

  included do
    after_rollback :log_status, on: %i[create update]
  end

  def log_status
    Rails.logger.info "Rollback caused by: #{errors.full_messages}"
  end
end
