# bundle exec rake ridgepole:apply
namespace :ridgepole do
  desc "Apply ridgepole schemafile"
  # DB定義変更
  task apply: :environment do
    ridgepole
  end

  # ALTER文確認
  task dry_run: :environment do
    ridgepole('--dry-run')
  end

  desc "Export ridgepole schemafile"
  task export: :environment do
    ridgepole('--export')
  end

  private
  def ridgepole(*options)
    command = ['bundle exec ridgepole --file Schemafile', "-c config/database.yml", "-E #{Rails.env} --apply"]
    system (command + options).join(' ')
  end
end