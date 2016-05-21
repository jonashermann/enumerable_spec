class Array 
	 @@enum = []  
		 def my_each
				unless block_given?
					for i in 0..self.length-1
								@@enum << self[i]
					end  
							@@enum
				end 
					for i in 0..self.length-1
						yield self[i]
					end  
				 self 
				   
		 end

		 def my_each_with_index
			for i in 0..self.length-1
				yield i, self[i] 
			end	
			 self
		 end

		 def my_select

			arr = []
			for i in 0..self.length-1
				s = yield self[i]
				if s 
					arr << self[i]
				end
				 
			end	
			arr
		 
		 end

		 def my_all?

			ans = []
			unless block_given?
				for i in 0..self.length-1
           ans << self[i]
				end	
				if ans.include?false or ans.include? nil
					return false
				else
				   return true	
				end
			else
			for i in 0..self.length-1
					res = yield self[i]
					 ans.push res
			end	
					if ans.my_include? false 
						return false
					else
					 return true	
					end
			end		 
		 end

		 def my_include?(el) 
			j = 0
			for i in 0..self.length-1
				if el == self[i]
					return true
				else
						j += 1	
				end
			end	
				if j == length
					 return false
				end       
			
		 end
      def my_count(el)
      number_occurence = 0 
       
          self.my_each do|e|   
               if e == el
                 number_occurence += 1
               end
          end
       
       number_occurence
     end
		 def my_any?
			ans = []
			unless block_given?
				for i in 0..self.length-1
          ans << self[i]
				end	
				if ans.my_include? true
					 return true
				else
				    false
				end
			else
			for i in 0..self.length-1
					res = yield self[i]
					ans.push res
				end  
				if ans.my_include? true
					return true
				else
						return false
				end     	
		 end
    end
		 

		 def my_count_with_block
			res = []
			 for i in 0..self.length-1
					v = yield self[i]
					res.push v
			 end
				 res.my_count(true)
		 end

		 def my_map(&bloc)
			res = []
      unless block_given?
		    
		    return self.my_each	
		  else
			 for i in 0..self.length-1
			 	b = yield self[i]
				res.push b 
			 end  
			 return res
		end 
		end  

		 def my_inject
			res = 1
			 for i in 0..self.length-1
				res = yield self[i], res
			 end
			 res
		 end

		 
end

#tests

describe "Array" do
	include Enumerable
	let(:base_array) {[9,4,3,2,7,4,-4]}
	let(:empty_array) {[]}
	let(:with_nil_array) {[9,nil,6,5]}
	let(:all_false) {[nil,false,nil,false]}
	describe "#my_each" do
		
		 context "When a block is given" do
			 it "returns an array object" do
					expect(base_array.my_each {|num| num}).to be_instance_of (Array)
			 end 
		 end

			

			 it "returns the original array" do
					 expect(base_array.my_each {|num| num*5}).to eql(base_array) 
			 end

			 it "applies the block instructions" do
					a = []
					b = [11,6,5,4,9,6,-2]
					expect(base_array.my_each{|num| a << num +2}).to eql(base_array)
					expect(a).to eql(b)   
			 end 
		 end

		describe "#my_select" do
				context "When a block is given" do
					it "returns an array object" do
						 expect(base_array.my_select{|num| num}).to be_instance_of(Array)
					end  
				end  
				 
					it "returns all elements for which block returns true" do
					 expect(base_array.my_select {|x| x < 0}).to eql([-4])
					 expect(empty_array.my_select {|x| x > 0}).to eql(empty_array)
					 expect(with_nil_array.my_select {|x| x.nil?}).to eql([nil])
					 expect(all_false.my_select {|x| x.nil?}).to eql([nil, nil])
					 expect(all_false.my_select {|x| x == false}).to eql([false, false])
					end
					it"returns all elements for which the block returns true" do
					 expect(base_array.my_select{|x| x}).to eql(base_array)
					 expect(empty_array.my_select{|x| x}).to eql(empty_array)
					 expect(with_nil_array.my_select{|x| x}).to eql([9,6,5])
					 expect(all_false.my_select{|x| x}).to eql(empty_array)
				 end
			end	  
			describe "#my_count" do  

			context "if an argument is given" do
			it "returns a count of all elements equal to the argument" do
			 expect(with_nil_array.my_count(nil)).to eql(1) 
       expect(empty_array.my_count(2)).to eql(0) 
       expect(all_false.my_count(false)).to eql(2)
       expect(base_array.my_count(4)).to eql(2)
			end  
       				
			end 
		end

		  describe "#my_all?" do
		  	context "When no block is given" do
          it"returns true if no array elements are false or nil" do
           expect(base_array.my_all?).to be true
           expect(empty_array.my_all?).to be true
           expect(with_nil_array.my_all?).to be false
           expect(all_false.my_all?).to be false
          end
		 end 
		     context "When a block is given" do
           it "returns true if block returns true for all elements" do
            expect(base_array.my_all?{|x| x.even?}).to be false
            expect(empty_array.my_all?{|x| x}).to be true
            expect(with_nil_array.my_all?{|x| x.nil?}).to be false
            expect(all_false.my_all?{|x| x.nil? || x == false}).to be true

           end

		     end
		 end    
		  describe "#my_any?" do
		    context "When no block is given" do
         it "returns true if at least one element is not false or nil" do
           expect(base_array.my_any?).to be false
           expect(empty_array.my_any?).to be false 
           expect(with_nil_array.my_any?).to be false
           expect(all_false.my_any?).to be false
         end
        end

        context "when a block is given" do
          it "returns true if block returns true for at least one element" do
            expect(base_array.my_any?{|x| x.even?}).to be true
            expect(empty_array.my_any?{|x| x}).to be false
            expect(with_nil_array.my_any?{|x| x.nil?}).to be true
            expect(all_false.my_any?{|x| x.nil?}).to be true
          end 
         end 
	  end	   
   
   describe "my_map" do
      context "when a block is given" do
       it "returns an array object" do
        expect(base_array.my_map {|x| x}).to be_instance_of(Array)
       end
      end 
      it "creates a new array containing the values returned by the block" do
        expect(base_array.my_map{|x| x+2}).to eql([11,6,5,4,9,6,-2])
        expect(empty_array.my_map{|x| x+1}).to eql(empty_array)
        expect(with_nil_array.my_map{|x| x}).to eql(with_nil_array)
        expect(all_false.my_map{|x| x.nil?}).to eql([true,false,true,false])

      end	

   end
		   
end  