#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See COPYRIGHT and LICENSE files for more details.
#++

RSpec.shared_context 'with seeded projects, members and project custom fields' do
  let(:project) { create(:project, name: 'Foo project', identifier: 'foo-project') }
  let(:other_project) { create(:project, name: 'Bar project', identifier: 'bar-project') }

  let(:first_version) { create(:version, name: 'Version 1', project:) }
  let(:second_version) { create(:version, name: 'Version 2', project:) }

  let!(:admin) do
    create(:admin)
  end

  let!(:member_in_project) do
    create(:user,
           firstname: 'Member 1',
           lastname: 'In Project',
           member_with_permissions: { project => %w[
             view_work_packages
           ] })
  end

  let!(:another_member_in_project) do
    create(:user,
           firstname: 'Member 2',
           lastname: 'In Project',
           member_with_permissions: { project => %w[
             view_work_packages
           ] })
  end

  let!(:section_for_input_fields) { create(:project_custom_field_section, name: 'Input fields') }
  let!(:section_for_select_fields) { create(:project_custom_field_section, name: 'Select fields') }
  let!(:section_for_multi_select_fields) { create(:project_custom_field_section, name: 'Multi select fields') }

  let!(:boolean_project_custom_field) do
    field = create(:boolean_project_custom_field, projects: [project], name: 'Boolean field',
                                                  project_custom_field_section: section_for_input_fields)

    create(:custom_value, customized: project, custom_field: field, value: true)

    field
  end

  let!(:string_project_custom_field) do
    field = create(:string_project_custom_field, projects: [project], name: 'String field',
                                                 project_custom_field_section: section_for_input_fields)

    create(:custom_value, customized: project, custom_field: field, value: 'Foo')

    field
  end

  let!(:integer_project_custom_field) do
    field = create(:integer_project_custom_field, projects: [project], name: 'Integer field',
                                                  project_custom_field_section: section_for_input_fields)

    create(:custom_value, customized: project, custom_field: field, value: 123)

    field
  end

  let!(:float_project_custom_field) do
    field = create(:float_project_custom_field, projects: [project], name: 'Float field',
                                                project_custom_field_section: section_for_input_fields)

    create(:custom_value, customized: project, custom_field: field, value: 123.456)

    field
  end

  let!(:date_project_custom_field) do
    field = create(:date_project_custom_field, projects: [project], name: 'Date field',
                                               project_custom_field_section: section_for_input_fields)

    create(:custom_value, customized: project, custom_field: field, value: Date.new(2024, 1, 1))

    field
  end

  let!(:text_project_custom_field) do
    field = create(:text_project_custom_field, projects: [project], name: 'Text field',
                                               project_custom_field_section: section_for_input_fields)

    create(:custom_value, customized: project, custom_field: field, value: "Lorem\nipsum")

    field
  end

  let!(:list_project_custom_field) do
    field = create(:list_project_custom_field, projects: [project], name: 'List field',
                                               project_custom_field_section: section_for_select_fields,
                                               possible_values: ['Option 1', 'Option 2', 'Option 3'])

    create(:custom_value, customized: project, custom_field: field, value: field.custom_options.first)

    field
  end

  let!(:version_project_custom_field) do
    field = create(:version_project_custom_field, projects: [project], name: 'Version field',
                                                  project_custom_field_section: section_for_select_fields)

    create(:custom_value, customized: project, custom_field: field, value: first_version.id)

    field
  end

  let!(:user_project_custom_field) do
    field = create(:user_project_custom_field, projects: [project], name: 'User field',
                                               project_custom_field_section: section_for_select_fields)

    create(:custom_value, customized: project, custom_field: field, value: member_in_project.id)

    field
  end

  let!(:multi_list_project_custom_field) do
    field = create(:list_project_custom_field, projects: [project], name: 'Multi list field',
                                               project_custom_field_section: section_for_multi_select_fields,
                                               possible_values: ['Option 1', 'Option 2', 'Option 3'],
                                               multi_value: true)

    create(:custom_value, customized: project, custom_field: field, value: field.custom_options.first.id)
    create(:custom_value, customized: project, custom_field: field, value: field.custom_options.second.id)

    field
  end

  let!(:multi_version_project_custom_field) do
    field = create(:version_project_custom_field, projects: [project], name: 'Multi version field',
                                                  project_custom_field_section: section_for_multi_select_fields,
                                                  multi_value: true)

    create(:custom_value, customized: project, custom_field: field, value: first_version.id)
    create(:custom_value, customized: project, custom_field: field, value: second_version.id)

    field
  end

  let!(:multi_user_project_custom_field) do
    field = create(:user_project_custom_field, projects: [project], name: 'Multi user field',
                                               project_custom_field_section: section_for_multi_select_fields,
                                               multi_value: true)

    create(:custom_value, customized: project, custom_field: field, value: member_in_project.id)
    create(:custom_value, customized: project, custom_field: field, value: another_member_in_project.id)

    field
  end

  let!(:input_fields) do
    [
      boolean_project_custom_field,
      string_project_custom_field,
      integer_project_custom_field,
      float_project_custom_field,
      date_project_custom_field,
      text_project_custom_field
    ]
  end

  let!(:select_fields) do
    [
      list_project_custom_field,
      version_project_custom_field,
      user_project_custom_field
    ]
  end

  let!(:multi_select_fields) do
    [
      multi_list_project_custom_field,
      multi_version_project_custom_field,
      multi_user_project_custom_field
    ]
  end
end
