class Contact < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :subject
  validates_presence_of :body

  # in format of: grouped_options_for_select
  def available_subjects
    [
      ['', [ ['',''] ] ],
      ['The Website',
        [
          ['Comments / Questions / Suggestions','Website - Comments/Questions/Suggestions'],
          ['Tech Support','Website - Tech Support'],
          ['Found a Bug','Website - Found a Bug'],
          ['Content / Typos','Website - Content/Typos'],
        ]
      ],
      ['The Firefox Add-on',
        [
          ['Comments / Questions / Suggestions','Addon - Comments/Questions/Suggestions'],
          ['Tech Support','Addon - Tech Support'],
          ['Found a Bug','Addon - Found a Bug'],
          ['Content / Typos','Addon - Content/Typos'],
        ]
      ],
      ['Or...',
        [
          ['Advertising','Advertising'],
          ['Partnerships','Partnerships'],
          ['Press','Press'],
          ['Jobs','Jobs'],
        ]
      ],
    ]
  end

end
