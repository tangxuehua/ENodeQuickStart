using ECommon.Components;
using ENode.Commanding;
using NoteSample.Commands;
using NoteSample.Domain;

namespace NoteSample.CommandHandlers
{
    [Component]
    public class NoteCommandHandler :
        ICommandHandler<CreateNoteCommand>,
        ICommandHandler<ChangeNoteTitleCommand>
    {
        public void Handle(ICommandContext context, CreateNoteCommand command)
        {
            context.Add(new Note(command.AggregateRootId, command.Title));
        }
        public void Handle(ICommandContext context, ChangeNoteTitleCommand command)
        {
            context.Get<Note>(command.AggregateRootId).ChangeTitle(command.Title);
        }
    }
}
