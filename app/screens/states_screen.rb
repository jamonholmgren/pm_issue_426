class StatesScreen < PM::TableScreen
  searchable placeholder: "Search states"
  refreshable

  title "States"

  def on_refresh
    update_table_data
    stop_refreshing
  end

  def on_load
    # Causes drawing issues.
    # @entry_model_change_observer = App.notification_center.observe 'StateDataChanged' do |notification|
    #   update_table_data
    # end
  end

  def table_data
    [{
      title: "",
      cells: State.all.map { |state|
        {
          title: state.name,
          action: :tapped_state, 
          editing_style: :delete,
          arguments: { state_id: state.id }
        }
      }
    }]
  end

  def tapped_state(args={})
    PM.logger.debug args
  end

  def on_cell_deleted(cell={})
    if cell[:arguments][:state_id]
      State.remove(cell[:arguments][:state_id])
    end
  end
end
