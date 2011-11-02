class CoursesUsers < ActiveRecord::Base
  # provide import functionality for Course Users
  # if user does not exist, it will be created and added to this course
  def self.import(row,session,id,line_ind)
    error_s = ""
    if row.length > 4
      error_s += "extra items exist,"
    end

    error_s += " 'username' is missing, " if row[0] == nil or row[0].strip.empty?
    error_s += " 'password' is missing, " if row[3] == nil or row[3].strip.empty?
    error_s += " 'email address' is missing, " if row[2] == nil or row[2].strip.empty?
    error_s += " 'full name' is missing, " if row[1] == nil or row[1].strip.empty?
    raise ArgumentError,"line #{line_ind}: " + error_s if !error_s.empty?
    user = User.find_by_name(row[0])
    if (user == nil)
      attributes = ImportFileHelper::define_attributes(row)
      user = ImportFileHelper::create_new_user(attributes,session)
    end
    if id == nil
      raise MissingObjectIDError
    end
    course = Course.find(id)
    if course == nil
      raise ImportError, "The course with id \""+id.to_s+"\" was not found."
    end
    if (CoursesUsers.find(:all, {:conditions => ['user_id=? AND course_id=?', user.id, course.id]}).size == 0)
      CoursesUsers.create :user_id => user.id, :course_id => course.id
    end
  end

  def email(pw, home_page)
    user = User.find_by_id(self.user_id)
    course = Course.find_by_id(self.course_id)
    Mailer.deliver_message(
        {:recipients => user.email,
         :subject => "You have been registered as a participant in #{course.title}",
         :body => {
             :home_page => home_page,
             :user_name => ApplicationHelper::get_user_first_name(user),
             :name =>user.name,
             :password =>pw,
             :partial_name => "register"
         }
        }
    )
  end

end
