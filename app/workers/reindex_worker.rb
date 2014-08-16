class ReindexWorker
  include Sidekiq::Worker
  sidekiq_options queue: :elasticsearch

  def perform(id, klass)
    instance = klass.constantize.find(id)
    instance.reindex
  end
end
