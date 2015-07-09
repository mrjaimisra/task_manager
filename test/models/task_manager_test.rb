require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description" })
    task = TaskManager.find(TaskManager.all.first)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
  end

  def test_it_finds_all_tasks
    TaskManager.create({ :title => "1st title", :description => "1st description" })
    TaskManager.create({ :title => "2nd title", :description => "2nd description" })
    TaskManager.create({ :title => "3rd title", :description => "3rd description" })
    tasks = TaskManager.all

    assert_equal "3rd title", tasks.last.title
    assert_equal "1st description", tasks.first.description
  end

  def test_it_finds_a_task_by_id
    TaskManager.create({ :title => "a title", :description => "a description" })
    TaskManager.create({ :title => "2nd title", :description => "2nd description" })

    assert_equal "a description", TaskManager.find(TaskManager.all.first.id).description
  end

  def test_it_updates_a_task
    task = TaskManager.create({ :title => "a title", :description => "a description" })
    TaskManager.update(task.id, {title: "sweet title", description: "a new description"})

    assert_equal "sweet title", TaskManager.find(task.id).title
    assert_equal "a new description", TaskManager.find(task.id).description
  end

  def test_it_annihilates_a_task_into_oblivion
    task = TaskManager.create({ :title => "a title", :description => "a description" })
    TaskManager.create({ :title => "2nd title", :description => "2nd description" })

    total = TaskManager.all.count

    TaskManager.delete(TaskManager.all.last.id)

    assert_equal (total - 1), TaskManager.all.count
    refute TaskManager.all.include?(task)
  end
end