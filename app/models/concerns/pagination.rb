# frozen_string_literal: true

module Pagination
  extend ActiveSupport::Concern

  # Config allows for environment defined limitations to pagination
  class Config
    attr_writer :page_limit

    def page_limit
      @page_limit ||= 100
    end
  end

  def self.config
    @config ||= Pagination::Config.new
  end

  def self.configure
    yield config
  end

  class_methods do
    # Paginate manages paginagated DB queries and conforms to #as_json interface
    # @param query [Hash] The DB query hash
    # @param sort_by [String|Symbol] The key on the record to sort by
    # @param order [String|Symbol] The sort order :asc || :desc
    # @param offset [Integer] The offset for the data set
    # @return [Hash] Hash containing the records and meta data of the query
    def paginate(query:, sort_by:, order:, offset:)
      offset ||= 0

      total = where(query)
      records = total.order(sort_by => order).limit(page_limit).offset(offset)

      result_with_meta(total, records, order, offset)
    end

    private

    def result_with_meta(total, records, order, offset)
      {
        record_type => records,
        meta: {
          order:  order,
          limit:  page_limit,
          offset: offset,
          total:  total.count
        }
      }
    end

    def record_type
      name.underscore.pluralize.to_sym
    end

    def page_limit
      Pagination.config.page_limit
    end
  end
end
