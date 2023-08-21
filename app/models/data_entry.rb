class DataEntry < ApplicationRecord
    validates :name, presence: true
end
