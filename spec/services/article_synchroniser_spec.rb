require 'rails_helper'

RSpec.describe ArticleSynchroniser do
  describe '#article_fetcher' do
    context 'When initialised without an article_fetcher' do
      let(:the_default_fetcher_type) { ArticleApiConnection }
      let(:an_instance) { ArticleSynchroniser.new }
      it 'returns the default fetcher type' do
        expect(an_instance.article_fetcher).to be_a(the_default_fetcher_type)
      end
    end
    context 'When initialised with an invalid article_fetcher' do
      let(:an_instance) { ArticleSynchroniser.new(article_fetcher: Class.new )}
      it 'raises an error' do
        expect{an_instance}.to raise_error(ArticleSynchroniser::ArticleFetcherUnsupportedError)
      end
    end
    context 'When initialised with a valid article_fetcher' do
      let(:articles) { [] }
      let(:an_instance) { ArticleSynchroniser.new(article_fetcher: OpenStruct.new(fetch_articles: articles))}
      it 'does not error' do
        expect{an_instance}.to_not raise_error
      end
    end
  end
  describe '#sync_and_publish!' do
    context 'when initialised with a valid article_fetcher' do
      context 'When the article_fetcher returns articles' do
        let(:articles) { [{'id' => 9},{'id' => 10}] }
        let(:an_instance) { ArticleSynchroniser.new(article_fetcher: OpenStruct.new(fetch_articles: articles))}
        context 'when no local articles exist' do
          it 'creates published articles' do
            expect(Article.published.count).to eql 0
            an_instance.sync_and_publish!
            expect(Article.published.count).to eql articles.count
          end
        end
        context 'when local articles exist' do
          let(:article_defs) {
            [{api_id: 9, published_at: Time.current}, {api_id: 10, published_at: Time.current}]
          }
          let(:local_articles) { Article.create!(article_defs) }
          let(:articles) { [{'id' => 9, 'title' => 'Hello'},{'id' => 11, 'title' => 'There'}] }
          let(:an_instance) { ArticleSynchroniser.new(article_fetcher: OpenStruct.new(fetch_articles: articles))}
          it 'synchronises published articles and unpublishes articles not present' do
            la_count = local_articles.count
            expect(Article.published.count).to eql la_count
            an_instance.sync_and_publish!
            expect(Article.published.count).to eql 2
            published_articles = Article.published
            published_article_api_ids = published_articles.pluck(:api_id)
            expect(published_article_api_ids).to include(11,9)
            expect(published_article_api_ids).to_not include(10)
            expect(published_articles.where(api_id: 9).first.title).to eql 'Hello'
          end
        end
      end
      context 'when the article_fetcher returns no articles' do
        let(:articles) { [] }
        let(:an_instance) { ArticleSynchroniser.new(article_fetcher: OpenStruct.new(fetch_articles: articles))}
        context 'when local articles exist' do
          let(:article_defs) {
            [{api_id: 9, published_at: Time.current}, {api_id: 10, published_at: Time.current}]
          }
          let(:local_articles) { Article.create!(article_defs) }
          it 'unpublishes all articles' do
            la_count = local_articles.count
            expect(Article.published.count).to eql la_count
            an_instance.sync_and_publish!
            expect(Article.published.count).to eql 0
          end
        end
      end
    end
  end
end
