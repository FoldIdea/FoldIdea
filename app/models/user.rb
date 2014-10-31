class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_temp_handle

  DEFAULT_BLANK_HANDLE = 'New Member'

  def display_handle
    handle.presence || DEFAULT_BLANK_HANDLE
  end

  def temp_handle
    handle = ''
    unless email.blank?
      handle = email.sub(/@.*/, '')
      if match = handle.match(/(\w+)\.(\w)/)
        handle = "#{match.captures[0].capitalize}.#{match.captures[1].upcase}"
      end
    end
    handle
  end

  def self.is_handle_unique?(test_handle)
    User.exists?(handle: test_handle)
  end

private
  def set_temp_handle
    th = temp_handle
    self.handle = (!th.blank? && User.is_handle_unique?(th)) ? th : ''
  end
end
