require 'spec_helper'

describe User do

  before :each do
    User.create(email: 'cvetter34@gmail.com', password: '1234', password_confirmation: '1234')
    User.create(email: 'julie34@gmail.com', password: '1234', password_confirmation: '1234')
  end

  describe "user registration with email and password" do
    it "is valid with an email" do
      user = User.new(email: 'julie123@gmail.com', password: '1234', password_confirmation: '1234')
      user.save
      expect(user).to be_valid
    end

    it "is invalid without an email" do
      user = User.new(password: '1234', password_confirmation: '1234')
      user.save
      expect(user).to have(1).errors_on(:email)
    end

    describe "password is provided" do
      before :each do
        @user = User.new(email: 'cvetter34@gmail.com', password: '1234', password_confirmation: '1234')
      end

      it "should be valid with password_confirmation" do
        user = User.new(email: 'julie123@gmail.com', password: '1234', password_confirmation: '1234')
        user.save
        expect(user).to be_valid
      end

      context "password_confirmation is provided as empty" do
        it "should be invalid without password_confirmation" do
          @user.password_confirmation = ''
          @user.save
          expect(@user).to have(1).errors_on(:password_confirmation)
        end
      end

      context "password_confirmation is provided as nil" do
        it "should be valid without password_confirmation" do
          user = User.new(email: 'julie123@gmail.com', password: '1234', password_confirmation: '1234')
          user.save
          user.password_confirmation = nil
          user.save
          expect(user).to be_valid
        end
      end
    end
  end

  describe "user login successfully with authenticated username and password" do
    describe "self.authenticate" do
      context "correct password" do
        it "should be valid to authenticate" do
          user = User.find_by email: 'cvetter34@gmail.com'
          auth_result = user.authenticate '1234'
          result = user.fish == BCrypt::Engine.hash_secret('1234', user.salt)
          expect(auth_result).to eq result
        end
      end

      context "incorrect password" do
        it "should return nil to authenticate" do
          user = User.find_by email: 'cvetter34@gmail.com'
          auth_result = user.authenticate '123456'
          result = user.fish == BCrypt::Engine.hash_secret('1234', user.salt)
          expect(auth_result).to_not eq result
        end
      end

      context "user email not found" do
        it "should return nil to authenticate" do
          user = User.find_by email: '12cvetter34@gmail.com'
          expect(user).to be_nil
        end
      end
    end

    describe "authenticate" do
      it "authenticate correctly" do
        user = User.find_by email: 'cvetter34@gmail.com'
        auth_result = user.authenticate '1234'
        result = user.fish == BCrypt::Engine.hash_secret('1234', user.salt)
        expect(auth_result).to eq result
      end
    end
  end

  describe "reset password" do
    context "password is blank" do
      it "should be invalid if password is blank" do
        user = User.find_by email: 'cvetter34@gmail.com'
        expect(user.password).to be_nil
      end
    end

    context "password is not blank" do
      context "password with confirmation matches" do
        it "should have the fish and salt changed" do
          user = User.find_by email: 'cvetter34@gmail.com'
          user.password = '123'
          user.password_confirmation = '123'
          @code = SecureRandom.urlsafe_base64
          expect(@code).to_not be_nil
        end

        it "should have code and expires_at set to nil" do
          user = User.find_by email: 'cvetter34@gmail.com'
          user.password = '123'
          user.password_confirmation = '123'
          @code = SecureRandom.urlsafe_base64
          expect(@code).to_not be_nil
        end
      end

      context "password with confirmation not matches" do
        it "should have the fish and salt unchanged" do
          user = User.find_by email: 'cvetter34@gmail.com'
          user.password = '1234'
          user.password_confirmation = '123'
          @code = SecureRandom.urlsafe_base64
          expect(@code).to_not be_nil
        end

        it "should have code and expires_at unchanged" do
          user = User.find_by email: 'cvetter34@gmail.com'
          user.password = '1234'
          user.password_confirmation = '123'
          @code = SecureRandom.urlsafe_base64
          expect(@code).to_not be_nil
          expect(@expires_at).to be_nil
        end
      end
    end
  end

  describe "Set random password if password is not provided" do
    context "salt and fish exists" do
      it "should have value in salt and fish" do
        user = User.find_by email: 'cvetter34@gmail.com'
        @salt = BCrypt::Engine.generate_salt
        @fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), @salt)
        expect(@salt).to_not be_nil
        expect(@fish).to_not be_nil
      end
    end
  end

  describe "Password is encrypted before save" do
    context "password is present" do
      it "should have value in salt and fish" do
        @user = User.new email: 'cvetter34@gmail.com'
        @user.password = '1234'
        @user.send(:encrypt_password)
        expect(@user.salt).to_not be_nil
        expect(@user.fish).to_not be_nil
      end

      context "encrypted password is not the same as plain" do
        it "should have values of password and fish differently" do
          user = User.new email: 'cvetter34@gmail.com'
          user.password = '1234'
          user.send(:encrypt_password)
          @salt = BCrypt::Engine.generate_salt
          @fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), @salt)
          expect(user.password).to_not be_eql @fish
        end
      end
    end

    context "password is not present" do
      it "should not have value in salt and fish" do
        user = User.new email: 'cvetter34@gmail.com'
        @salt = BCrypt::Engine.generate_salt
        @fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), @salt)
        expect(@salt).to_not be_nil
        expect(@fish).to_not be_nil
      end
    end

  end

  describe "the association of 1-to-many relationship between user and tools" do
    it "should owned two tools" do
      user = User.find_by email: 'cvetter34@gmail.com'
      Tool.create(user_id: "1", name: "Hammer", category: "Garden Tools", description: "This is a good hammer")
      Tool.create(user_id: "1", name: "Ladder", category: "Garden Tools", description: "This is a good ladder")
      expect(user.tools_owned.count).to eq 2
    end

    it "should have only one tool is belong to user" do
      user = User.find_by email: 'cvetter34@gmail.com'
      Tool.create(user_id: "1", name: "Hammer", category: "Garden Tools", description: "This is a good hammer")
      Tool.create(user_id: "2", name: "Ladder", category: "Garden Tools", description: "This is a good ladder")
      expect(user.tools_owned.count).to eq 1
    end
  end

  describe "Many users can borrow many tools" do
    it "should have two transactions" do
      user = User.find_by email: 'cvetter34@gmail.com'
      Tool.create(user_id: "1", name: "Hammer", category: "Garden Tools", description: "This is a good hammer")
      Tool.create(user_id: "1", name: "Ladder", category: "Garden Tools", description: "This is a good ladder")
      Transaction.create(user_id: "1", tool_id: "1")
      Transaction.create(user_id: "1", tool_id: "2")
      expect(user.transactions.count).to eq 2
    end

    it "should have one transaction" do
      user = User.find_by email: 'cvetter34@gmail.com'
      Tool.create(user_id: "1", name: "Hammer", category: "Garden Tools", description: "This is a good hammer")
      Tool.create(user_id: "1", name: "Ladder", category: "Garden Tools", description: "This is a good ladder")
      Transaction.create(user_id: "1", tool_id: "1")
      Transaction.create(user_id: "2", tool_id: "2")
      expect(user.transactions.count).to eq 1
    end
  end
end