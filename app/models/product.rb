class Product < ApplicationRecord
    self.primary_key = 'symbol'

    has_many :meta_data, foreign_key: "symbol", class_name: "ArticleMetaData"
end
