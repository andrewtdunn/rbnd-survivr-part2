class Tribe
    attr_reader :name, :members

    def initialize(options)
        @name = options[:name]
        @members = options[:members]
        puts @name + " tribe created"
    end

    def tribal_council(options = {})
        #if options[:immune] doesn't exist it will return as nil, and no members will be immune from the vote.
        voted_off = @members.reject { |member| member == options[:immune]}.sample
        @members.delete(voted_off)
    end

    def format_members
        member_list = ""
        @members.each.with_index do |member, index|
            member_list = member_list +  member.to_s_with_color
            if member != @members.last
                member_list +=  ", "
            end
        end
        member_list
    end

    def to_s
        @name
    end

end