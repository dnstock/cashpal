require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * controller_class_nesting_depth %>/../spec_helper')

describe <%= controller_class_name %>Controller do
  describe "handling GET /<%= table_name %>" do

    before(:each) do
      @<%= file_name %> = mock_model(<%= controller_class_name.singularize %>)
      <%= controller_class_name.singularize %>.stub!(:find).and_return([@<%= file_name %>])
    end

    def do_get
      get :index
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end

    it "should find all <%= table_name %>" do
      <%= controller_class_name.singularize %>.should_receive(:find).with(:all, anything()).and_return([@<%= file_name %>])
      do_get
    end
    it "should assign the found <%= table_name %> for the view" do
      do_get
      assigns[:<%= table_name %>].should == [@<%= file_name %>]
    end
  end

  describe "handling POST /<%= table_name %>" do

    before(:each) do
      @<%= file_name %> = mock_model(<%= controller_class_name.singularize %>, :to_param => "1")
      <%= controller_class_name.singularize %>.stub!(:new).and_return(@<%= file_name %>)
    end
    describe "with successful save" do
      def do_post
        @<%= file_name %>.should_receive(:to_ext_json)
        @<%= file_name %>.should_receive(:save).and_return(true)
        post :create, :<%= file_name %> => {}
      end
      it "should create a new <%= file_name %>" do
        <%= controller_class_name.singularize %>.should_receive(:new).with({}).and_return(@<%= file_name %>)
        do_post
      end

    end
    describe "with failed save" do

      def do_post
        @<%= file_name %>.should_receive(:to_ext_json)
        @<%= file_name %>.should_receive(:save).and_return(false)
        post :create, :<%= file_name %> => {}
      end

      it "should fail" do
        do_post
      end
    end
  end

  describe "handling PUT /<%= table_name %>/1" do

    before(:each) do
      @<%= file_name %> = mock_model(<%= controller_class_name.singularize %>, :to_param => "1")
      <%= controller_class_name.singularize %>.stub!(:find).and_return(@<%= file_name %>)
    end
    describe "with successful update" do

      def do_put
        @<%= file_name %>.should_receive(:to_ext_json)
        @<%= file_name %>.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the <%= file_name %> requested" do
        <%= controller_class_name.singularize %>.should_receive(:find).with("1").and_return(@<%= file_name %>)
        do_put
      end

      it "should update the found <%= file_name %>" do
        do_put
        assigns(:<%= file_name %>).should equal(@<%= file_name %>)
      end

      it "should assign the found <%= file_name %> for the view" do
        do_put
        assigns(:<%= file_name %>).should equal(@<%= file_name %>)
      end

    end
    describe "with failed update" do

      def do_put
        @<%= file_name %>.should_receive(:to_ext_json)
        @<%= file_name %>.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should fail" do
        do_put
      end

    end
  end

  describe "handling DELETE /<%= table_name %>/1" do

    before(:each) do
      @<%= file_name %> = mock_model(<%= controller_class_name.singularize %>, :destroy => true)
      <%= controller_class_name.singularize %>.stub!(:find).and_return(@<%= file_name %>)
    end
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the <%= file_name %> requested" do
      <%= controller_class_name.singularize %>.should_receive(:find).with("1").and_return(@<%= file_name %>)
      do_delete
    end
    it "should call destroy on the found <%= file_name %>" do
      @<%= file_name %>.should_receive(:destroy).and_return(true)
      do_delete
    end
    it "should redirect to the <%= table_name %> list" do
      do_delete
    end
  end
end