require 'rails_helper'

RSpec.describe Article, type: :model do

  describe "#validations" do

    let(:article) { build(:article) }

    it "tests that factory is valid" do
      expect(article).to be_valid # article.valid? == true
    end

    it "has an invalid title" do
      article.title = ''
      expect(article).not_to be_valid # article.valid? == true
      expect(article.errors[:title]).to include("can't be blank") # article.valid? == true
    end

    it "has an invalid content" do
      article.content = ''
      expect(article).not_to be_valid
      expect(article.errors[:content]).to include("can't be blank")
    end

    it "has an invalid slug" do
      article.slug = ''
      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include("can't be blank")
    end

    it "validates the uniqueness of slug" do
      new_article1 = create(:article, slug:'article1')
      new_article2 = build(:article, slug:'article1')
      print new_article2.errors
      expect(new_article2).not_to be_valid
      expect(new_article2.errors[:slug]).to include("has already been taken")
    end

  end

  describe '.recent' do
    it 'returns articles in proper order' do
      olderArticle = create(:article, created_at: 1.hour.ago)
      recentArticle = create(:article)
      expect(described_class.recent).to eq(
        [recentArticle,olderArticle]
      )
      recentArticle.update_column(:created_at, 2.hours.ago)
      expect(described_class.recent).to eq(
        [olderArticle,recentArticle]
      )
    end
  end
end
