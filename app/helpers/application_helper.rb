# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Garden Scheduler'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def full_description(page_description = '')
    base_description = 'Garden Schedulerは、家庭菜園やガーデニング用の栽培スケジュール通知サービスです。'
    if page_description.empty?
      base_description
    else
      page_description
    end
  end

  def og_description(page_description = '')
    base_description = 'Garden Schedulerは、家庭菜園やガーデニング用の栽培スケジュール通知サービスです。'
    if page_description.empty?
      base_description
    else
      page_description
    end
  end
end
