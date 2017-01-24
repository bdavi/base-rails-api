class MembershipInvitationExpirationJob < ApplicationJob
  queue_as :default

  def perform(membership_invitation)
    return unless membership_invitation&.status == "pending"
    membership_invitation.update! status: "expired"
  end

  rescue_from(ActiveJob::DeserializationError) do |exception|
    # Invitation was deleted before the job executes.
    # No action needed, so swallow the error to prevent retries.
  end
end
