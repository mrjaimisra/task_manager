require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  def test_it_creates_a_task
    TaskManager.create({ :title       => "a title",
                         :description => "a description" })
    task = TaskManager.find(1)
    assert_equal "a title", task.title
    assert_equal "a description", task.description
    assert_equal 1, task.id
  end

  def test_it_finds_all_tasks
    TaskManager.create({ :title => "1st title", :description => "1st description" })
    TaskManager.create({ :title => "2nd title", :description => "2nd description" })
    TaskManager.create({ :title => "3rd title", :description => "3rd description" })
    tasks = TaskManager.all

    assert_equal 3, tasks[2].id
    assert_equal "2nd title", tasks[1].title
    assert_equal "1st description", tasks[0].description
  end

  def test_it_finds_a_task_by_id
    TaskManager.create({ :title => "a title", :description => "a description" })
    TaskManager.create({ :title => "2nd title", :description => "2nd description" })

    assert_equal "2nd description", TaskManager.find(2).description
  end

  def test_it_updates_a_task
    TaskManager.create({ "title" => "a title", "description" => "a description" })
    TaskManager.update(1, {:id=>1, :title=>"sweet title", :description=>"a new description"})

    assert_equal "sweet title", TaskManager.find(1).title
    assert_equal "a new description", TaskManager.find(1).description
  end

  def test_it_annihilates_a_task_into_oblivion
    task = TaskManager.create({ :title => "a title", :description => "a description" })
    TaskManager.create({ :title => "2nd title", :description => "2nd description" })

    TaskManager.delete(1)

    assert_equal "2nd description", TaskManager.find(2).description
    refute TaskManager.all.include?(task)
  end
end