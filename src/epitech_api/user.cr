require "../epitech_api"
require "./mark"
require "./module"

module EpitechApi
  # A user represent an EPITECH student.
  #
  # To create a `User`:
  #
  # ```
  # user = User.new
  # ```
  class User
    @login    : String
    @credits  : Int32         = 0
    @marks    : Array(Mark)   = [] of Mark
    @modules  : Array(Module) = [] of Module

    # Base path, must be prefixed with user login before every path
    BASE_PATH = "/user"
    # Path to retrieve base infos of the user
    INFOS_PATH = { method: "get", path: "/" }
    # Path to retrieve the marks of the user
    MARKS_PATH = { method: "get", path: "/notes" }

    # Initialize the user at the creation.
    #
    # You must provide the login of the user.
    #
    # ```
    # user = User.new("roche_t")
    # ```
    def initialize(@login)
    end

    # Returns the number of times the student got -42
    #
    #```
    # count = user.cheat_count # : Int64
    #```
    def cheat_count
      count = 0
      @marks.each do |mark|
        count += 1 if mark.final_note == -42
      end
      count
    end

    # Returns the number of times the student got -21
    #
    #```
    # count = user.missed_count # : Int64
    #```
    def missed_count
      count = 0
      @marks.each do |mark|
        count += 1 if mark.final_note == -21
      end
      count
    end

    def marks
      @marks
    end

    # Retrieve the marks of the user. It returns an array of `Mark`
    # and populates @marks.
    #
    # This method uses blocking network operations.
    #
    # ```
    # user = User.new("roche_t")
    # marks = user.retrieve_marks # : Array(Mark)
    # ```
    def retrieve_marks
      response = EpitechApi.request(user_path(MARKS_PATH))
      json = JSON.parse(response.body) rescue {} of JSON::Any => JSON::Any
      marks = [] of Mark
      if json["notes"]? && json["notes"].as_a?
        json["notes"].as_a.each do |mark|
          if mark.is_a? Hash
            date = Time.parse(mark["date"].to_s, "%F %H:%M:%S")
            note = mark["final_note"].as? Float64
            note ||= mark["final_note"].as(Int64).to_f
            marks << Mark.new(mark["title"].to_s, date, note,
                              mark["comment"].to_s, mark["correcteur"].to_s)
          end
        end
      end
      @marks = marks
    end

    # Retrieve the infos of the user. It returns an Hash
    # and populates the user's infos.
    #
    # This method uses blocking network operations.
    #
    # ```
    # user = User.new("roche_t")
    # infos = user.retrieve_infos # : Hash
    # ```
    def retrieve_infos
    end

    # Retrieve all the infos available on the user.
    # It includes :
    #   - The base infos
    #   - The marks
    #
    # This method uses blocking network operations.
    #
    # ```
    # user = User.new("roche_t")
    # user.synchronize
    # ```
    def synchronize
      self.retrieve_infos
      self.retrieve_marks
    end

    # Returns a complete path for the given route scoped to the user.
    #
    # ```
    # user_path({ method: "get", path: "notes"  })
    # # => { method: path[:method], path: "/user/roche_t/notes}" }
    # ```
    private def user_path(path : NamedTuple(method: String, path: String))
      { method: path[:method], path: "#{BASE_PATH}/#{@login}/#{path[:path]}" }
    end
  end
end
