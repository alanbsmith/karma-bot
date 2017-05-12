class Bot < SlackRubyBot::Bot
  command 'help' do |client, data, match|
    client.say(channel: data.channel, text: help_message)
  end

  # users#index
  command 'list' do |client, data, match|
    user_list = User.all.map { |user| "#{user.name}: #{user.points}" }
    client.say(channel: data.channel, text: user_list.join(" \n "))
  end

  command 'top' do |client, data, match|
    user_list = User.all.sort_by { |user| user.points }.reverse!.first(10)
    leaderboard = user_list.map { |user| "#{user.name}: #{user.points}" }
    client.say(channel: data.channel, text: leaderboard.join(" \n "))
  end

  command 'bottom' do |client, data, match|
    user_list = User.all.sort_by { |user| user.points }.first(10)
    leaderboard = user_list.map { |user| "#{user.name}: #{user.points}" }
    client.say(channel: data.channel, text: leaderboard.join(" \n "))
  end

  # users#create
  match /^karma create @?(?<user>[\w|\.]+)/ do |client, data, match|
    username = "#{match[:user]}"
    user = User.find_by(name: username)
    if user
      client.say(channel: data.channel, text: user_exists_message(username))
    else
      User.create(name: username)
      client.say(channel: data.channel, text: create_success_message(username))
    end
  end

  #usersupdate karma (by id)
  scan(/(<@\w{9}>\s?[-|\+]{2})/) do |client, data, messages|
    messages.flatten.map do |message|
      user_id = message.gsub(/<|@|>|\+|\s/, '')
      username = client.users[user_id].name
      operation = message[-2,2]
      user = User.find_by(name: username)
      client_name = client.users[data.user].name
      if !user
        client.say(channel: data.channel, text: user_not_found_message)
      elsif client_name == username
        client.say(channel: data.channel, text: unauthorized_message(username))
      else
        update_karma(user, operation)
        message = operation == "++" ? add_karma_message(user.name, user.points) : lose_karma_message(user.name, user.points)
        client.say(channel: data.channel, text: message)
      end
    end
  end

  # users#update karma (by name)
  scan(/(@?[\w.]+\s?[-|\+]{2})+/) do |client, data, messages|
    messages.flatten.map do |message|
      username = message.gsub(/\+{2}|-{2}|@/, '').strip
      operation = message[-2,2]
      user = User.find_by(name: username)
      client_name = client.users[data.user].name
      if !user
        client.say(channel: data.channel, text: user_not_found_message)
      elsif client_name == username
        client.say(channel: data.channel, text: unauthorized_message(username))
      else
        update_karma(user, operation)
        message = operation == "++" ? add_karma_message(user.name, user.points) : lose_karma_message(user.name, user.points)
        client.say(channel: data.channel, text: message)
      end
    end
  end

  # users#empty karma
  match /^karma empty @?(?<user>[\w|\.]+)/ do |client, data, match|
    username = "#{match[:user]}"
    user = User.find_by(name: username)
    if !user
      client.say(channel: data.channel, text: user_not_found_message)
    else
      user.update_attributes(points: 0)
      client.say(channel: data.channel, text: empty_karma_message(username, 0))
    end
  end

  # users#destroy
  match /^karma destroy @?(?<user>[\w|\.]+)/ do |client, data, match|
    username = "#{match[:user]}"
    user = User.find_by(name: username)
    if !user
      client.say(channel: data.channel, text: user_not_found_message)
    else
      user.destroy
      client.say(channel: data.channel, text: destroy_success_message(username))
    end
  end

  private
  # FUNCTIONALITY
  def self.update_karma(user, operation)
    new_karma = operation == "++" ? user.points + 1 : user.points - 1
    user.update_attributes(points: new_karma)
  end

  # MESSAGES
  def self.help_message
    "list of commands: \n
    `karmabot list`: returns a list of users and their karma \n
    `karmabot top`: returns top 10 users \n
    `karmabot bottom`: returns bottom 10 users \n
    `karma create {username}`: creates a new user \n
    `{username} ++`: adds karma to user \n
    `{username} --`: removes karma from user \n
    `karma empty {username}`: resets user's karma \n
    `karma destroy {username}`: deletes user"
  end

  def self.create_success_message(username)
    "Karma has been created for #{username}!\nAdd karma with `#{username} ++` or remove with `#{username} --`"
  end

  def self.user_exists_message(username)
    "#{username} already exists!"
  end

  def self.user_not_found_message
    "Hmm... I don't know that name.\nYou can create them with `karma create {username}`"
  end

  def self.add_karma_message(username, karma)
    # add other phrases
    "#{username} is on the rise! Karma: #{karma}"
  end

  def self.lose_karma_message(username, karma)
    # add other phrases
    "#{username} was taken down a notch! Karma: #{karma}"
  end

  def self.unauthorized_message(username)
    "I'm sorry, #{username}, I can't do that. \n http://gph.is/28RqP3Q"
  end

  def self.empty_karma_message(username, karma)
    # add other phrases
    "#{username}'s karma has been reset. Karma: #{karma}"
  end

  def self.destroy_success_message(username)
    "#{username} has been removed"
  end
end
