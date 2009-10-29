# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fresnel_lib}
  s.version = "0.0.24"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Meyer and Paul Pagel, 8th Light"]
  s.date = %q{2009-10-29}
  s.description = %q{A library wrapping the ruby lighthouse-api}
  s.email = %q{paul@8thlight.com}
  s.files = ["lib/credential.rb", "lib/credential_saver.rb", "lib/encrypter.rb", "lib/lighthouse/adapter.rb", "lib/lighthouse/lighthouse.rb", "lib/lighthouse/lighthouse_api/base.rb", "lib/lighthouse/lighthouse_api/changed_attribute.rb", "lib/lighthouse/lighthouse_api/changed_attributes.rb", "lib/lighthouse/lighthouse_api/diffable_attributes.rb", "lib/lighthouse/lighthouse_api/project.rb", "lib/lighthouse/lighthouse_api/project_membership.rb", "lib/lighthouse/lighthouse_api/ticket.rb", "lib/lighthouse/lighthouse_api/ticket_accessors.rb", "lib/lighthouse/lighthouse_api/ticket_version.rb", "lib/lighthouse/lighthouse_api/user.rb", "lib/lighthouse/memory/base.rb", "lib/lighthouse/memory/milestone.rb", "lib/lighthouse/memory/project.rb", "lib/lighthouse/memory/project_membership.rb", "lib/lighthouse/memory/ticket.rb", "lib/lighthouse/memory/user.rb", "lib/stage_info.rb", "lib/stage_manager.rb", "spec/credential_saver_spec.rb", "spec/credential_spec.rb", "spec/encrypter_spec.rb", "spec/lighthouse/lighthouse_api/base_spec.rb", "spec/lighthouse/lighthouse_api/changed_attribute_spec.rb", "spec/lighthouse/lighthouse_api/changed_attributes_spec.rb", "spec/lighthouse/lighthouse_api/diffable_attributes_spec.rb", "spec/lighthouse/lighthouse_api/project_membership_spec.rb", "spec/lighthouse/lighthouse_api/project_spec.rb", "spec/lighthouse/lighthouse_api/ticket_accessors_spec.rb", "spec/lighthouse/lighthouse_api/ticket_spec.rb", "spec/lighthouse/lighthouse_api/ticket_version_spec.rb", "spec/lighthouse/lighthouse_api/user_spec.rb", "spec/lighthouse/lighthouse_spec.rb", "spec/lighthouse/memory/base_spec.rb", "spec/lighthouse/memory/memory_spec_helper.rb", "spec/lighthouse/memory/milestone_spec.rb", "spec/lighthouse/memory/project_membership_spec.rb", "spec/lighthouse/memory/project_spec.rb", "spec/lighthouse/memory/ticket_spec.rb", "spec/lighthouse/memory/user_spec.rb", "spec/spec_helper.rb", "spec/stage_info_spec.rb", "spec/stage_manager_spec.rb"]
  s.homepage = %q{http://github.com/paulwpagel/fresnel}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A library wrapping the ruby lighthouse-api}
  s.test_files = ["spec/credential_saver_spec.rb", "spec/credential_spec.rb", "spec/encrypter_spec.rb", "spec/stage_info_spec.rb", "spec/stage_manager_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
