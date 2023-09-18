# README

NOTES:


to create a schedule from a todo:
```
todo = Todo.create()
        todo.create_schedule()
```

        



QUESTIONS:

When i run the following commands in `rails console`
```
irb(main):001:0> todo = Todo.create(name: "project", info: "work on project")
=> #<Todo:0x00000193b67fd1b8 id: 2, name: nil, info: nil, created_at: Sat, 12 Aug 2023 13:14:22.342829000 UTC +00:00, updated_at: Sat, 12 Aug 2023 13:14:22.342829000 UTC +00:00>
irb(main):002:0> schedule = todo.create_schedule(saturday: 1)
=> #<Schedule:0x00000193b7036b90 id: 2, sunday: false, monday: false, tuesday: false, wednesday: false, thursday: false, friday: false, saturday: false, created_at: Sat, 12 Aug 2023 13:15:08.524008000 UTC +00:00, updated_at: Sat, 12 Aug 2023 13:15:08.524008000 UTC +00:00, todo_id: 2>
irb(main):003:0> Todo.find(2).name == todo.name
=> false
irb(main):004:0> Todo.find(2).name
=> nil

```
Why is it different? Shouldn't the third command return true since they should be returning `"project"` 


to start backend
```
rails s
```

to start frontend
```
cd front-end
npm start
```