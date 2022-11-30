# frozen_string_literal: true
module TopHelper

  def variety_choices
    Variety.all.map { |variety| [variety.name, variety.id] }
  end

  def prefecture_choices
    Prefecture.all.map { |prefecture| [prefecture.name, prefecture.id] }
  end

end
