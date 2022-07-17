require 'rails_helper'

RSpec.describe ArticleApiConnection do
  describe '#endpoint' do
    context 'When initialised without an endpoint' do
      let(:the_default_endpoint) { ARTICLE_API_ENDPOINT }
      let(:an_instance) { ArticleApiConnection.new }
      it 'returns the originally specified endpoint' do
        expect(an_instance.endpoint).to eql the_default_endpoint
      end
    end
    context 'When initialised with a valid endpoint' do
      let(:a_valid_url) { 'https://www.google.com' }
      let(:an_instance) { ArticleApiConnection.new(endpoint: a_valid_url)}
      it 'returns the originally specified endpoint' do
        expect(an_instance.endpoint).to eql a_valid_url
      end
    end
  end
  describe '#fetch_articles', vcr: {record: :new_episodes} do
    context 'When initialised with the default endpoint' do
      let(:an_instance) { ArticleApiConnection.new }
      it 'returns data' do
        # We're not testing the API here
        # So test against a previous recording
        expect(an_instance.fetch_articles).not_to be_empty
      end
    end
    context 'When initialised with an invalid endpoint' do
      let(:an_invalid_url) { 'ftp://zork%' }
      let(:an_instance) { ArticleApiConnection.new(endpoint: an_invalid_url)}
      it 'raises an error' do
        expect{an_instance.fetch_articles}.to raise_error(ArticleApiConnection::ArticleFetchError)
      end
    end
  end

end
