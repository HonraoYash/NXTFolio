# frozen_string_literal: true

class GeneralInfo < ApplicationRecord
  has_many :gallery, dependent: :destroy, foreign_key: 'GeneralInfo_id'
  has_many :messages, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :login_info

  # For follow feature
  has_many(:follows, foreign_key: :followee, dependent: :destroy)
  has_many(:follows_from, class_name: :Follow,
                          foreign_key: :follower, dependent: :destroy)
  has_many :followers, through: :follows, source: :follower
  has_many :follows_others, through: :follows_from, source: :followee

  # NXTFolio : Added in Spring 2023 for tagging feature
  has_many :gallery_taggings
  has_many :tagged_gallery, through: :gallery_taggings, source: :gallery

  # List of all collaborators our user has collaborated with
  has_many :collaborations, foreign_key: :general_info_id
  has_many :collaborators, through: :collaborations, source: :collaborator

  validates_length_of   :highlights, minimum: 1
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :company
  validates_presence_of :industry
  validates_presence_of :highlights
  validates_presence_of :country
  validates_presence_of :state
  validates_presence_of :city
  validates_presence_of :emailaddr
  # validates_presence_of :job_name
  serialize :job_attr, Hash

  # validates :phone, numericality: true

  mount_uploader :profile_picture, AvatarUploader
  mount_uploader :cover_picture, CoverUploader
  mount_uploaders :gallery_pictures, GalleryUploader

  geocoded_by :address
  after_validation :geocode

  def address
    [city, state, country].compact.join(', ')
  end

  # def name
  #   self[:name]
  # end

  def self.search(search_arg)
    location = nil
    location = search_arg[:location] if search_arg[:location].present? && (search_arg[:location] != '')

    distance = 20
    distance = Integer(search_arg[:distance]) if search_arg[:distance].present? && (search_arg[:distance] != '')

    query = if !location.nil?
              GeneralInfo.near(location, distance)
            else
              GeneralInfo.all
            end

    if search_arg[:first_name].present?
      case search_arg[:first_name_regex]
      when 'Contains'
        search_arg[:first_name] = "%#{search_arg[:first_name]}%"
      when 'Starts With'
        search_arg[:first_name] = "#{search_arg[:first_name]}%"
      when 'Ends With'
        search_arg[:first_name] = "%#{search_arg[:first_name]}"
      when 'Exactly Matches'
        search_arg[:first_name] = search_arg[:first_name]
      end
      query = query.where('first_name ILIKE ?', search_arg[:first_name])
    end

    if search_arg[:last_name].present?
      case search_arg[:last_name_regex]
      when 'Contains'
        search_arg[:last_name] = "%#{search_arg[:last_name]}%"
      when 'Starts With'
        search_arg[:last_name] = "#{search_arg[:last_name]}%"
      when 'Ends With'
        search_arg[:last_name] = "%#{search_arg[:last_name]}"
      when 'Exactly Matches'
        search_arg[:last_name] = search_arg[:last_name]
      end
      query = query.where('last_name ILIKE ?', search_arg[:last_name])
    end

    if search_arg[:gender].present? && (search_arg[:gender] != 'Any')
      query = query.where('gender ILIKE ?', search_arg[:gender])
    end

    if search_arg[:compensation].present? && (search_arg[:compensation] != 'Any')
      search_arg[:compensation] = "%#{search_arg[:compensation]}%"
      query = query.where('compensation ILIKE ?', search_arg[:compensation])
    end

    if search_arg[:job_type].present? && (search_arg[:job_type] != 'Any')
      query = query.where('job_name ILIKE ?', search_arg[:job_type])
    end

    query
  end

  # Sets appearance of profile view attributes
  def attribute_values
    @attribute_values = {}
    @attribute_values[:name] = "Name: #{first_name} #{last_name}"
    @attribute_values[:phone] = "Phone: #{phone}"
    @attribute_values[:birthday] =
      "Birthday: #{month_ofbirth} / #{day_ofbirth} / #{year_ofbirth}"
    @attribute_values[:gender] = "Gender: #{gender}"
    @attribute_values[:location] = "Location: #{city}, #{state}, #{country}"
    @attribute_values[:compensation] = "Compensation: #{compensation}"
    @attribute_values[:facebook_link] = "Facebook: #{facebook_link}"
    @attribute_values[:linkedIn_link] = "LinkedIn: #{linkedIn_link}"
    @attribute_values[:instagram_link] = "Instagram: #{instagram_link}"
    @attribute_values[:personalWebsite_link] = "Personal website: #{personalWebsite_link}"
    @attribute_values[:bio] = "Biography: #{bio}"
    @attribute_values[:job_name] = job_name.to_s
    @attribute_values[:job_attr] = job_attr
    @attribute_values
  end

  # Create/Define Jobs by dynamically creating classes

  @@AcceptableAttrTypes = %w[Integer Float String]

  @@Job_List = []
  @@Job_Attr = {}
  @@Attr_Type = {}
  # Need code to populate job based off of existing database (For server reboots)

  def self.see_Jobs
    jobList = @@Job_List
    jobList.delete('Admin')
    jobList
  end

  def self.see_Types
    @@AcceptableAttrTypes
  end

  def self.check_Job?(jobName)
    if jobName == 'Admin'
      false
    else
      @@Job_List.include?(jobName)
    end
  end

  def self.delete_Job(jobName)
    return unless check_Job?(jobName)

    @@Job_List.delete(jobName)
    jobString = '\''
    @@Job_List.each do |job|
      jobString = "#{jobString}#{job}'"
    end
    $redis.set('jobList', jobString)
    $redis.del(jobName)

    # Code here to edit the database entries
  end

  def self.load_Job_File
    jobString = $redis.get('jobList')
    if !jobString.nil? && jobString != ''
      jobArray = jobString.scan(/\w+/)
      jobArray.each do |job|
        attrString = $redis.get(job)
        next if attrString.nil? # If there's a redis for this job

        eachAttrMatch = attrString.to_enum(:scan, /\w+(\s\w+)*(%)/).map { Regexp.last_match }
        eachTypeMatch = # Not really implemented yet, just a copy of the attribute name
          attrString.to_enum(:scan, /\w+(\s\w+)*(,|')/).map do
            Regexp.last_match
          end
        eachAttrMatch = eachAttrMatch.flatten
        eachTypeMatch.flatten

        create_Job(job, false)
        next unless !eachAttrMatch.nil? && eachAttrMatch.size.positive?

        eachAttrMatch.each do |attr|
          job.constantize.add_Attr(attr.to_s.chop, 'String', false) # Add the types you get from TypeMatch to further specialize this
        end
        job.constantize.update_File
      end
    else # Job Redis is empty/ never been used. Initialize Admin role
      $redis.set('jobList', '\'Admin\'')
      $redis.set('Admin', '')
      create_Job('Admin', false)
    end

    # @@Job_List = jobArray
  end

  def self.create_Job(className, writeToFile = true)
    # Code to validate the job name has chars only will go here

    return unless check_Job?(className.upcase_first) == false && className != 'Admin' && className != 'admin'

    @@Job_List.push(className.upcase_first)
    @@Job_Attr[className.upcase_first] = []
    @@Attr_Type[className.upcase_first] = []

    # Create entry in Job File List

    Object.const_set(className.upcase_first, Class.new do
      def self.display_Name
        name
      end

      # def display_Name()
      # self.display_Name()
      # end

      # def initialize()

      # end

      def self.add_Attr(attr_Name, attr_Type = 'String', writeToRedis = true)
        # If Name not in hash already
        return unless @@Job_Attr[name].include?(attr_Name) == false

        @@Job_Attr[name].push(attr_Name)
        @@Attr_Type[name].push(attr_Type)
        return unless writeToRedis

        update_File

        # Else Error, name already exists
      end

      # def add_Attr(attr_Name, attr_Type = "String", writeToRedis = true)
      # self.add_Attr(attr_Name, attr_Type, writeToRedis)
      # end

      def self.edit_Attr(attr_Name, new_Name, new_Type = nil)
        indexLoc = @@Job_Attr[name].find_index(attr_Name)

        return unless indexLoc

        @@Job_Attr[name][indexLoc] = new_Name
        @@Attr_Type[name] = new_Type unless new_Type.nil?
        update_File
        # Code to run through database and edit all existing entries
      end

      # def edit_Attr(attr_Name, new_Name, new_Type = nil)
      # self.edit_Attr(attr_Name, new_Name, new_Type)
      # end

      def self.delete_Attr(attr_Name)
        indexLoc = @@Job_Attr[name].find_index(attr_Name)

        return unless indexLoc

        @@Job_Attr[name].delete_at(indexLoc)
        @@Attr_Type[name].delete_at(indexLoc)
        update_File
        # Code to shift all attributes into place in database is in Admin controller
      end

      # def delete_Attr(attr_Name)
      # self.delete_Attr(attr_Name)
      # end

      def self.view_Attr
        @@Job_Attr[name]
      end

      # def view_Attr()
      # self.view_Attr()
      # end

      def self.view_Attr_Type(attr_Name = nil)
        if attr_Name.nil?
          @@Attr_Type[name]
        else
          indexLoc = @@Attr_Type[name].find_index(attr_Name)

          @@Attr_Type[name][indexLoc] if indexLoc
        end
      end

      # def view_Attr_Type(attr_Name)
      # self.view_Attr_Type(attr_Name)
      # end

      def self.update_File
        name
        attr_Body = '\''
        x = 0
        while x < @@Job_Attr[name].size
          attr_Body = "#{attr_Body}#{@@Job_Attr[name][x]}%#{@@Attr_Type[name][x]}'"
          x += 1
        end
        attr_Body = '\'\'' if attr_Body == '\''
        #      new_line = self.display_Name + " " + attr_Body
        #      file_cont = File.read ("jobList.dat")
        #      new_cont = file_cont.gsub(/^(#{Regexp.escape(self_Name)}).*/, new_line)
        #      File.open("jobList.dat", "w") {|file| file.puts new_cont}
        $redis.set(name, attr_Body)
      end

      # def update_File()
      # self.update_File()
      # end
    end)

    writeToFile = true
    return unless writeToFile

    jobString = '\''
    @@Job_List.each do |job|
      jobString = "#{jobString}#{job}'"
    end
    jobString = "#{jobString}#{className.upcase_first}'"
    $redis.set('jobList', jobString)
    $redis.set(className.upcase_first, '')
  end

  def follow(id)
    followee = GeneralInfo.find(id)
    Follow.create!(follower: self, followee:)
  end

  def unfollow(id)
    followee = GeneralInfo.find(id)
    follows_others.delete(followee)
  end

  def get_followers
    followers
  end

  def get_users_they_follow
    follows_others
  end

  def self.filterBy(country, state, profession, city)
    # filter by profession, country, state
    @filteredUsers = profession.present? ? GeneralInfo.where(job_name: profession) : GeneralInfo.all
    # @filteredUsers = @filteredUsers.where(country: country) #United States

    # @filteredUsers = country.present? ? GeneralInfo.where(country: country) : @filteredUsers
    @filteredUsers = country.present? ? @filteredUsers.where(country:) : @filteredUsers

    @filteredUsers = state.present? ? @filteredUsers.where(state:) : @filteredUsers
    # adding city on filter list
    # @filteredUsers = city.present? ? @filteredUsers.where(city: city) : @filteredUsers
    @filteredUsers = city.present? ? @filteredUsers.where('LOWER(city) = ?', city.downcase) : @filteredUsers

    # @filteredUsers.each do |room|
    #  puts "users are: #{room[:first_name]}"
    # end

    # add travel feature
    # if the profession travels to the city within 30 days,
    # he should show up in the search results
    @filteredUsers1 = profession.present? ? GeneralInfo.where(job_name: profession) : GeneralInfo.all
    @filteredUsers1 = country.present? ? @filteredUsers1.where(travel_country: country) : @filteredUsers1
    @filteredUsers1 = state.present? ? @filteredUsers1.where(travel_state: state) : @filteredUsers1
    @filteredUsers1 = city.present? ? @filteredUsers1.where(travel_city: city) : @filteredUsers1
    # @filteredUsers1 = @filteredUsers1.where(travel_start: Date.today..30.days.from_now.to_date) + \
    #                   @filteredUsers1.where.not(travel_start: Date.today..30.days.from_now.to_date).
    @filteredUsers1 = @filteredUsers1.where(travel_start: Date.today..30.days.from_now.to_date)\
                                     .or(@filteredUsers1.where(travel_end: Date.today..30.days.from_now.to_date)\
                    .or(@filteredUsers1.where('travel_start < ?', Date.today).where('travel_end > ?', Date.today)))

    @filteredUsers.or(@filteredUsers1)
  end
end
