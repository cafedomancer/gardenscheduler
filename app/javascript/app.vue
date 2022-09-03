<template>
  <div @click="addTask()">作業追加</div>
  <div v-for="(task, index) in tasks" :key="index">
    <input type='text' v-model="tasks[index][id]" :name="'tasks[' + index + '][id]'" />
    <input type='text' v-model="tasks[index][name]" :name="'tasks[' + index + '][name]'" />
    <input type='text' v-model="tasks[index][date]" :name="'tasks[' + index + '][date]'" />
    <input type='text' v-model="tasks[index][plan_memo]" :name="'tasks[' + index + '][plan_memo]'" />
    <span @click="deleteTask(index)">×</span>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        tasks: [{id: 0, name: "", date: null, plan_memo:""}]
      }
    },
    methods: {
      addTask () {
        this.tasks.push('')
      },
      deleteTask (index) {
        this.tasks.splice(index, 1)
      }
    }
  }
  </script>
