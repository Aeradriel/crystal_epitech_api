require "./mark"

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

    # Initialize the user at the creation.
    #
    # You must provide the login of the user.
    #
    # ```
    # user = User.new("roche_t")
    # ```
    def initialize(@login)
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
    end
  end
end
