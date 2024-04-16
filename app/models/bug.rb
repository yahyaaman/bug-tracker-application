class Bug < ApplicationRecord
    after_initialize :set_default_bug_type, if: :new_record?
    after_initialize :set_default_bug_status, if: :new_record?

    belongs_to :user
    belongs_to :project
    belongs_to :developer, class_name: 'User', foreign_key: 'developer_id', optional: true
    
    enum bug_type: [:feature, :bug]
    enum bug_status: [:opened, :started, :completed, :resolved]

    has_one_attached :screenshot
    validate :screenshot_file_type 
    validates :title, :bug_type, :bug_status, presence: true
    validates :title, uniqueness: true

    def self.status_options(bug_type)
        case bug_type
        when "feature"
            %w[opened started completed]
        when "bug"
            %w[opened started resolved]
        end
    end


    private

    def set_default_bug_type
      self.bug_type ||= :feature
    end
    
    def set_default_bug_status
      self.bug_status ||= :opened
    end

    def screenshot_file_type
      if screenshot.attached? && !screenshot.content_type.in?(%w(image/png image/gif))
        errors.add(:image, 'must be a PNG or GIF')
      end
    end
    
end
