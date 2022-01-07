import Header from '@/components/header/header.vue'
import Menu from '@/components/menu/menu.vue'


export default {
    name: 'App',

    components: {
        Header,
        Menu
    },

    computed: {
        route: function () {
            return this.$route.path.split('/')[1]
        }
    }
}