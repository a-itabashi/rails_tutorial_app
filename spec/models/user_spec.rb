require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create(:user)}

  describe "FactoryBotの検証" do
    it "通常のユーザーは有効かどうか" do
      expect(user).to be_valid
    end
  end

  describe "#name" do
    context "名前が空欄の場合" do
      it "無効な状態かどうか" do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
    end
    context "名前が50文字を超えた場合" do
      it "無効な状態かどうか" do
        user = FactoryBot.build(:user, name: "a"*51)
        user.valid?
        expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
      end
    end
  end

  describe "#email" do
    context "メールアドレスが空欄の場合" do
      it "無効な状態かどうか" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
    end
    context "メールアドレスが255文字を超えた場合" do
      it "無効な状態かどうか" do
        user = FactoryBot.build(:user, email: "a"*255+"@example.com")
        user.valid?
        expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
      end
    end
    context "メールアドレスが重複していた場合" do
      it "無効な状態かどうか" do
        user = FactoryBot.create(:user, email: 'test@example.com')
        user_sample = FactoryBot.build(:user, email: 'test@example.com')
        user_sample.valid?
        expect(user_sample.errors[:email]).to include("has already been taken")
      end
    end
    context "メールアドレスに大文字か小文字かの条件以外、重複している場合" do
      it "無効な状態かどうか" do
        user = FactoryBot.create(:user, email: 'test@example.com')
        user_sample = FactoryBot.build(:user, email: 'TEST@example.com')
        user_sample.valid?
        expect(user_sample.errors[:email]).to include("has already been taken")
      end
    end
  end

end
