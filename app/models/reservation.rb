class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :checkin_at, presence: true
  validates :checkout_at, presence: true
  validates :guest_count, presence: true, numericality: { greater_than_or_equal_to: 1 }

  validate :checkin_at_cannot_be_in_the_past
  validate :checkout_at_must_be_after_checkin_at

  private

  def checkin_at_cannot_be_in_the_past
    return if checkin_at.blank?

    if checkin_at < Date.current
      errors.add(:checkin_at, "は今日以降の日付を選択してください")
    end
  end

  def checkout_at_must_be_after_checkin_at
    return if checkin_at.blank? || checkout_at.blank?

    if checkout_at <= checkin_at
      errors.add(:checkout_at, "はチェックイン日より後の日付を選択してください")
    end
  end
end
