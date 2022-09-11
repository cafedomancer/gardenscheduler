<template>
  <div @click="addTask()">作業追加</div>
  <div v-for="( task, index) in taskList" :key="task.id">
    <input type='hidden' v-model="task.id" :name="'tasks[' + index + '][id]'" />
    <select v-model="task.name" :name="'tasks[' + index + '][name]'">
      <option disabled value="">作業名</option>
      <option v-for="taskName in taskNames" 
        v-bind:value="taskName.name" 
        v-bind:key="taskName.id">
      {{ taskName.name }}
      </option>
    </select>
    <input type='date' v-model="task.date" :name="'tasks[' + index + '][date]'" />
    <input type='text' v-model="task.plan_memo" :name="'tasks[' + index + '][plan_memo]'" />
    <button class="btn btn-warning btn-sm destroy" @click="deleteTask(index)">削除</button>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        taskList: [{id: 0, name: "", date: null, plan_memo:""}],
        taskNames: [
          {id: 0, name: '土作り'},
          {id: 1, name: '元肥'},
          {id: 2, name: '追肥'},
          {id: 3, name: '剪定'}
        ]
      }
    },
    methods: {
      addTask () {
        this.taskList.push({})
      },
      deleteTask (index) {
        this.taskList.splice(index, 1)
      }
    }
  }
  </script>
