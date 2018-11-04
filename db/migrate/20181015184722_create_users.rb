class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension "pgcrypto"

    create_table :users, id: :uuid do |t|
      t.string :name, limit: 255
      t.string :email, null: false, limit: 255
      t.string :password_digest, null: false, limit: 255

      ## Sessions
      # [
      #   { digest: sessionDigest, token: tokenValue, revoked: Boolean }
      # ]
      t.jsonb :sessions, default: [], null: false

      ## Recoverable
      # {
      #   reset_password_token: string,
      #   reset_password_sent_at: datetime
      # }
      t.jsonb :recovery, default: {}, null: false

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # {
      #   sign_in_count: integer,
      #   current_sign_in_at: datetime,
      #   last_sign_in_at: datetime,
      #   current_sign_in_ip: datetime,
      #   last_sign_sessions: []
      # }
      t.jsonb :tracking, default: {}, null: false

      ## Confirmable
      # {
      #   confirmation_token: string,
      #   confirmed_at: datetime,
      #   confirmation_sent_at: datetime,
      # }
      t.jsonb :confirmation, default: {}, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :sessions, using: :gin, opclass: :jsonb_path_ops
  end
end
