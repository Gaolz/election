loadElectionVue = ->
    if $("#search_form").length
        bscd = new Vue({
            el: "#search_form",
            data: ->
                title: null,
                items: [],
                visible: false,
                error: null

            methods: {
                onSearch: ->
                    if bscd.title
                        $("#category-index").hide()
                        $("#carouselExampleIndicators").hide()
                        bscd.visible = true
                        $.ajax "/search",
                            type: 'GET'
                            contentType: 'application/json'
                            data: {
                                search: this.title,
                            }
                            success: (res) ->
                                bscd.items = res

                    else
                        bscd.visible = false
                        $("#category-index").show()
                        $("#carouselExampleIndicators").show()
            }
        })

$(document).on 'turbolinks:load', ->
    loadElectionVue()