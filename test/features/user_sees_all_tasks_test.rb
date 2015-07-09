require_relative '../test_helper'

class UserSeesAllTasksTest < FeatureTest
  def test_homepage_displays_welcome_message
  #   WWUD
  #   go to a webpage
  #   look at the rendered page
  #   they would see the stuff they are looking for
    visit("/")
    assert_equal "/", current_path
    assert page.has_content?("Welcome to the Task Manager")
  end

  def test_homepage_title_has_css_id_hello
    visit("/")
    within("body") do
      assert page.has_css?("#greeting")
    end
  end

  def test_user_can_fill_in_task_form
    visit("/")
    click_link("New Task")

    assert_equal "/tasks/new", current_path

    fill_in("task[title]", with: "pizza")
    fill_in("task[description]", with: "longer pizza")
    click_button("Create Task")

    assert_equal "/tasks", current_path

    within(".container") do
      assert page.has_content?("pizza")
    end
  end

  def test_user_can_edit_a_task
    visit("/")

    click_link("New Task")

    assert_equal "/tasks/new", current_path

    fill_in("task[title]", with: "pizza")
    fill_in("task[description]", with: "longer pizza")

    assert_equal "/tasks/new", current_path
    click_button("Create Task")

    within(".container") do
      assert page.has_content?("pizza")
    end

    assert_equal "/tasks", current_path

    click_link("edit")

    assert_equal "/tasks/1/edit", current_path
  end
end
