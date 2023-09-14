class User < ApplicationRecord
    validates :name, presence: { message: "名前を入力してください" }, length: { maximum: 30 }
    validates :email, presence: { message: "メールアドレスを入力してください" }, length: { maximum: 255 }, uniqueness: { message: "メールアドレスはすでに使用されています" }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, presence: { message: "パスワードを入力してください" }, length: { minimum: 6, message: "パスワードは6文字以上で入力してください" }
    validate :password_confirmation_matches

    has_many :tasks, dependent: :destroy

    def destroy_with_tasks
      self.destroy
    end
    
  private

  def password_confirmation_matches
    if password.present? && password_confirmation.present? && password != password_confirmation
      errors.add(:password_confirmation, "パスワード（確認）とパスワードの入力が一致しません")
    end
  end
  
end
