class ImportFileController < ApplicationController
  before_filter :start
  def start
    @id = params[:id]
    @expected_fields = params[:expected_fields]
    @model = params[:model]
    @title = params[:title]
  end

  def import
    errors = importFile(session,params)
    err_msg = "The following errors were encountered during import.<br/>Other records may have been added. A second submission will not duplicate these records.<br/><ul>"
    errors.each{
        |error|
      err_msg = err_msg+"<li>"+error+"<br/>"
    }
    err_msg = err_msg+"</ul>"
    if errors.length > 0
      flash[:error] = err_msg
    end
    redirect_to session[:return_to]
  end

  protected

  ############################this method is modified
  def importFile(session,params)


    delimiter = get_delimiter(params)
    file = params['file']
    errors = Array.new
    #############################add line
    exp_order = order_init(params) if (params[:model] != 'AssignmentTeam' and params[:model] != 'CourseTeam')
    ############################end

    file.each_line.inject(1) do |line_ind, line|
      line.chomp!
      unless line.empty?
        row = parse_line(line,delimiter)

        begin
          if params[:model] == 'AssignmentTeam' or params[:model] == 'CourseTeam'
            Object.const_get(params[:model]).import(row,session,params[:id],params[:options],line_ind)

          else
            ###########################add line
            row = organize_row(row, exp_order)
            ############################end

            if params[:model] == 'SignUpTopic'
              session[:assignment_id] = params[:id]
              Object.const_get(params[:model]).import(row,session,params[:id],line_ind)
            else
              Object.const_get(params[:model]).import(row,session,params[:id],line_ind)
            end
          end
        rescue
          errors << $!
        end
      end
      line_ind + 1
    end
    return errors
  end
  ###################################end

  def get_delimiter(params)
    delim_type = params[:delim_type]
    delimiter = case delim_type
                  when "comma" then ","
                  when "space" then " "
                  when "tab" then "\t"
                  when "other" then params[:other_char]
                end
    return delimiter
  end

  ####################################add line

  def order_init(params)

    option=params[:assigned_field]

    exp = params[:expected_fields]


    assigned = [option[:field1],option[:field2],option[:field3],option[:field4]]

    expect = exp.split(", ")
    order = Array.new
    assigned.each do |valueA|
      expect.inject(0) do |indexE, valueE|
        order << indexE  if valueA.strip == valueE.strip
        indexE+1
      end
    end
    order
  end

  def organize_row(row, order)
    if row.size != 4
      row.size.upto(3) do |i|
        order.delete(i)
      end

    end

    newRow = Array.new(row.size)
    order.inject(0) do |index, value|
      newRow[value] = row[index]
      index+1
    end
    newRow
  end
  #####################################end


  def parse_line(line, delimiter)
    if delimiter == ","
      items = line.split(/,(?=(?:[^\"]*\"[^\"]*\")*(?![^\"]*\"))/)
    else
      items = line.split(delimiter)
    end
    row = Array.new
    items.each { | value | row << value.sub("\"","").sub("\"","").strip }
    return row
  end
end