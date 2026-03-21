import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar'
import { Tooltip, TooltipContent, TooltipTrigger } from '@/components/ui/tooltip'

import { User } from '@renderer/admin/components/layout/types'

export default function UserAvatar({
  user,
  showMetadata = true,
  className = ''
}: {
  user: User
  showMetadata?: boolean
  className?: string
}) {
  return (
    <div className={`${showMetadata && 'flex gap-2'} ${className}`}>
      <Tooltip>
        <TooltipTrigger asChild>
          <Avatar className="size-10 rounded-full">
            <AvatarImage src={user.avatar} alt={user.name} />
            <AvatarFallback className="rounded-lg">
              {user.name.slice(0, 2).toUpperCase()}
            </AvatarFallback>
          </Avatar>
        </TooltipTrigger>
        <TooltipContent>
          <p>{user.name}</p>
        </TooltipContent>
      </Tooltip>
      {showMetadata && (
        <div className="grid flex-1 text-start text-sm leading-tight">
          <span className="truncate font-semibold">{user.name}</span>
          <span className="truncate text-xs">{user.email}</span>
        </div>
      )}
    </div>
  )
}
