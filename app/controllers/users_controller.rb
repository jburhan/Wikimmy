class UsersController < ApplicationController

  def downgrade
    current_user.update_attribute(:role, 'standard')

    current_user.pages.where(private: true).update_all(private: false).page.save!

  end

end
