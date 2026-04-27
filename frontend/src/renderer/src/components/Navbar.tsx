import { Search, User, ClipboardList } from 'lucide-react'

import { Link } from 'react-router-dom'

import { useAuthStore } from '@renderer/stores/auth-store'

import { ThemeSwitch } from '@renderer/components/theme-switch'
import { Button } from '@renderer/components/ui'
import { Avatar, AvatarFallback } from '@renderer/components/ui/avatar'

export default function Navbar() {
  const { user } = useAuthStore()

  return (
    <div className="bg-gray-800 fixed top-0 left-0 w-full h-14 z-50 flex items-center justify-end px-6 shadow-md">
      {/* TITLE CENTER */}
      <div className="absolute left-1/2 -translate-x-1/2 text-main text-2xl font-bold tracking-widest">
        <a href="/">LUMINA SUITES®</a>
      </div>

      {/* RIGHT MENU */}
      <div className="flex items-center gap-1">
        <ThemeSwitch className="text-white" />

        <Link to="/search/">
          <Button variant="ghost" className="rounded-full">
            <Search className="text-white" />
          </Button>
        </Link>

        <Link to="/bookingdetail">
          <Button variant="ghost" className="rounded-full">
            <ClipboardList className="text-white" />
          </Button>
        </Link>

        {!user ? (
          <Link to="/sign-in">
<<<<<<< HEAD
            <Button variant="ghost" className="rounded-full h-10 w-10 p-0">
              <User className="size-5" />
            </Button>
=======
            <User className="size-5! text-white" />
>>>>>>> 788bdfa0e3c82a1b4030cb174062ccfd49437134
          </Link>
        ) : (
          <Link to="/admin">
            <Button variant="ghost" className="rounded-full h-10 w-10 p-0 overflow-hidden">
              <Avatar className="size-full">
                <AvatarFallback className="text-sm font-medium">
                  {user.name.slice(0, 2).toUpperCase()}
                </AvatarFallback>
              </Avatar>
            </Button>
          </Link>
        )}
      </div>
    </div>
  )
}
