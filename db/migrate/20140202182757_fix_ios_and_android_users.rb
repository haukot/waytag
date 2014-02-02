class FixIosAndAndroidUsers < ActiveRecord::Migration
  def change
    Report.where(sourceable_type: 'IosUser').update_all(sourceable_id: nil, sourceable_type: nil)
    Report.where(sourceable_type: 'AndroidUser').update_all(sourceable_id: nil, sourceable_type: nil)
  end
end
