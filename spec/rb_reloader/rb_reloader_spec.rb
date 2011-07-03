require File.expand_path("../../spec_helper", __FILE__)

require File.expand_path("../test1", __FILE__)
require File.expand_path("../folder1/folder2/folder3/test4", __FILE__)

describe RbReloader do
  it "should reload test1" do
    
    Test1.m1("t1").should == "t1"

    current_folder = File.expand_path("..", __FILE__)    
    RbReloader.register(["#{current_folder}/**/t*.rb"])

    change_test1
    
    RbReloader.reload
    
    # call the m2
    Test1.m2("t2").should == "t2"
    
    change_back_test1
  end
  
  it "should reload test4" do
    Test4.m4("t4").should == "t4"

    current_folder = File.expand_path("..", __FILE__)    
    RbReloader.register(["#{current_folder}/**/t*.rb"])

    change_test4
    
    RbReloader.reload
    
    # call the m2
    Test4.m5("t5").should == "t5"
    
    change_back_test4
    
  end
end

def change_test1
  # change the test1.rb to add a new method t2
  File.open(File.expand_path("../test1.rb", __FILE__), "r+") do |file|
    counter  = 0
    while (line = file.gets)
      counter = counter + 1
      if counter == 4
        file <<  "def self.m2(p2) \n p2 \n end \n end"
      end
    end
  end  
end

def change_test4
  # change the test1.rb to add a new method t2
  File.open(File.expand_path("../folder1/folder2/folder3/test4.rb", __FILE__), "r+") do |file|
    counter  = 0
    while (line = file.gets)
      counter = counter + 1
      if counter == 4
        file <<  "def self.m5(p2) \n p2 \n end \n end"
      end
    end
  end  
end

def change_back_test1
      # change back the test1.rb
  File.open(File.expand_path("../test1.rb", __FILE__), "w") do |file|
    file << <<-CONTENT
module Test1
  def self.m1(p1)
    p1
  end
end      
    CONTENT
  end
  
end

def change_back_test4
      # change back the test1.rb
  File.open(File.expand_path("../folder1/folder2/folder3/test4.rb", __FILE__), "w") do |file|
    file << <<-CONTENT
module Test4
  def self.m4(p)
    p
  end
end      
    CONTENT
  end
  
end