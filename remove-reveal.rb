require 'Xcodeproj'

::TARGET_NAME = "barpass"
::PROJECT_NAME = "barpass"
xcproj = Xcodeproj::Project.open("#{PROJECT_NAME}.xcodeproj")
xcproj.targets.each do |t|
	if t.name == TARGET_NAME 
		t.frameworks_build_phase.files_references.each do |f|
			if f.path == "Reveal.framework" 
				puts "Found \"#{f.path}\", removing framework from build phase."
				t.frameworks_build_phase.remove_file_reference f
				break
			end
		end
	end
end 

xcproj.frameworks_group.files.each do |f|
	if f.path == "Reveal.framework" 
		puts "Found \"#{f.path}\", removing it from frameworks group."
		xcproj.frameworks_group.remove_reference f
		break
	end	
end
xcproj.save
